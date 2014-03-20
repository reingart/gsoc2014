#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QLabel>
#include <QVBoxLayout>
#include <QPushButton>
#include <QMessageBox>

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{

    QWidget *panel = new QWidget;

    QLabel *hello = new QLabel("hello world!");
    button = new QPushButton("&Quit");

    QVBoxLayout *vbox = new QVBoxLayout;
    vbox->addWidget(hello);
    vbox->addWidget(button);
    panel->setLayout(vbox);

    ui->setupUi(this);
    this->setCentralWidget(panel);
    connect(button, SIGNAL(released()), this, SLOT(greet()));
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::greet()
{
    // change the text
    button->setText("Example");
    QMessageBox msgbox;
    msgbox.setText("this app was created by Mariano Reingart for GSOC 2014");
    msgbox.exec();
}

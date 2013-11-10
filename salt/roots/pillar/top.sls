
base:
  'plone':
    - bccvl.plone
    - bccvl.users
    - bccvl.sshkeys
  'visualiser':
    - bccvl.visualiser
    - bccvl.virtualenv
    - bccvl.python
    - bccvl.sshkeys
  'data-mover':
    - bccvl.data_mover
    - bccvl.virtualenv
    - bccvl.python
    - bccvl.sshkeys
  'combined':
    - bccvl.plone
    - bccvl.visualiser
    - bccvl.users
    - bccvl.virtualenv
    - bccvl.python
    - bccvl.data_mover
    - bccvl.sshkeys

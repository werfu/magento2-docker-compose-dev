### October 3rd, 2018
* Created this changelog
* The Varnish implementation is now fully working. A default Magento VCL (4.0) has been commited too, but the Varnish folder has been added to ignore file, so it will allow added more VCL without having to commit them.
* Splitted Nginx container into two different containers, one for HTTP and the other for HTTPS. Configuration folder has been splitted too. It should allow replacing Nginx as a SSL termination easily too if required.
* The SSL generation script has been renamed generate_cert, moved to bin folder and now output a certificate to www.(key|crt) inside the conf/certs folder. 
# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT72 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/7.2.34.tar.gz?commit=5539cefcda6aca7af220e7be7760a682abb88200"
  sha256 "78dc4cb45f02883e933bbcdf3960a776a7103b4c37ca50970ec2cb0a2c157a77"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any, arm64_big_sur: "de8639e053cf959c65ed79ddb481d8a1cdd8bbf1d79bb5a5bd3b675fd734263f"
    sha256 cellar: :any, big_sur:       "718eed548909732b25f7c34c93ed080f40e8e30de4633f127bfd84b736e9e618"
    sha256 cellar: :any, catalina:      "5a79082440efe55a09b125545771ce531614315e2511db53804501a97e2ca0d6"
  end

  depends_on "imap-uw"
  depends_on "openssl@1.1"
  depends_on "krb5"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", \
           "--prefix=#{prefix}", \
           phpconfig, \
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end

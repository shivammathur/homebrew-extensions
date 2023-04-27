# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT81 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.1.18.tar.xz"
  sha256 "f3553370f8ba42729a9ce75eed17a2111d32433a43b615694f6a571b8bad0e39"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "47c4d6c4973b46dc7aecf854d79c7cef571b5c53b443825ca52d8a2cee26092f"
    sha256 cellar: :any,                 arm64_big_sur:  "6ede910a2e89c3946d139143072ad626641c86d4b88e59a855370d71fddfd690"
    sha256 cellar: :any,                 ventura:        "0bedfac21d609061dce453eaaed178ceb8f6c1d1184f93d002036fc8e4577bca"
    sha256 cellar: :any,                 monterey:       "f73a2cf8d128a100e73ebc71dd152ac358d067fe8ce53270fc189485b776be6c"
    sha256 cellar: :any,                 big_sur:        "1dd0ef1129b557832229c7c9c6b72e1ffe24fc4117ab770e279e4376d1942ba4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "62eaa7063fa70280742a7644f08bda5c26b523af511899b0d032e439d9700b4a"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}", \
           phpconfig,
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}", \
           "--with-imap-ssl=#{Formula["openssl@1.1"].opt_prefix}", \
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end

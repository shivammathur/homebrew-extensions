# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT70 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/da64b9b864bf43d9023d6d1d6d5b582800d72c9e.tar.gz"
  version "7.0.33"
  sha256 "c412fdeac66cb816f3f3fa5a7a6755daf3f37521d997fca771ecd40f61b22cc3"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-7.0-security-backports"
  license "PHP-3.01"
  revision 1

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 15
    sha256 cellar: :any, arm64_sequoia: "15549b5c25dff93a2c80c3ffc29dff8b060725e72c070f28b9cae8625ae1b3ae"
    sha256 cellar: :any, arm64_sonoma:  "58a11821adfeb0e6b83a81c8fa56f834553ee3328f70188311918a3d931f0075"
    sha256 cellar: :any, sonoma:        "a8f029784dae50beea67e7141e4f0cfd54c72d05d74454c1eb5c4e46bdf1d2a7"
    sha256 cellar: :any, arm64_linux:   "0f08a42548bd9b1299735510bcbddebdbff8b47ca0fafd46e7beb69934092dd2"
    sha256 cellar: :any, x86_64_linux:  "ecaff923d52d58e3b237950514e826cfd6eb60e96de36b15bf790bca3ce37f70"
  end

  depends_on "krb5"
  depends_on "openssl@3"
  depends_on "shivammathur/extensions/imap-uw"

  def install
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure",
           "--prefix=#{prefix}",
           phpconfig,
           "--with-imap=shared, #{Utils::Path.formula_opt_prefix("imap-uw")}",
           "--with-imap-ssl=#{Utils::Path.formula_opt_prefix("openssl@3")}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end

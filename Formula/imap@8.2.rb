# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/php/php-src/archive/663b037c7b54c1b829d59ed8f35ceb38d8cc3975.tar.gz?commit=663b037c7b54c1b829d59ed8f35ceb38d8cc3975"
  version "8.2.0"
  sha256 "d70573759e19c6b179a3ccb281c6d8d9f7350d8fcc6dd2c3335163721eecc14c"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 67
    sha256 cellar: :any,                 arm64_monterey: "3efc3d58c27d20ffb3e9db1db13f3a9b18d42e94261cfda6047eea287490a4a8"
    sha256 cellar: :any,                 arm64_big_sur:  "8a4b69711d2d39099d81f4930238d96f0e8218b42f4576a4dcfad7a5dc5bb000"
    sha256 cellar: :any,                 monterey:       "1f7831ebba159f24c14330ce7b3c2052a35886ee0db2276ff73303f2eef5fd18"
    sha256 cellar: :any,                 big_sur:        "999819c001f091e0c5af04f7427baa36e11b11c550a19966ff0ccf457527108f"
    sha256 cellar: :any,                 catalina:       "b4dd53bf0eeeb1d7a9b0490917ad2a125a6613cde6ed9be5e10f8fb0b5ac1913"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "93f492da94aa3bcd3dfb75d0b45cab2c9b9ff4b36ef3f4c9cbc99586021ca877"
  end

  depends_on "krb5"
  depends_on "openssl@1.1"
  depends_on "shivammathur/extensions/imap-uw"

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

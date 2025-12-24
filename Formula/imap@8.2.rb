# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT82 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.2.30.tar.xz"
  sha256 "bc90523e17af4db46157e75d0c9ef0b9d0030b0514e62c26ba7b513b8c4eb015"
  head "https://github.com/php/php-src.git", branch: "PHP-8.2"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads"
    regex(/href=.*?php-(8.2.\d+)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "80f3ca75b44e3f4194b12a46e4c4c885d564f0a4d5bc7403b8f2db2f7967aad3"
    sha256 cellar: :any,                 arm64_sonoma:  "8934c2589d6b4c886094bd5dce04dc05d09e9c49d4f293d43a459fd7c6234840"
    sha256 cellar: :any,                 sonoma:        "b501b020e4bdf2039ae2702b2d28657b6bf637bc252621172c79f88adc183d85"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0f579b8f46d303b49bf33b8c3231bbf240403505d9e51eb3b70796c1ab135045"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aa165a61f0d92664851d114883d22a7b7e4b43360b372344fef0f0912f103b87"
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
           "--with-imap=shared, #{Formula["imap-uw"].opt_prefix}",
           "--with-imap-ssl=#{Formula["openssl@3"].opt_prefix}",
           "--with-kerberos"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end

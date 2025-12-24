# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Imap Extension
class ImapAT80 < AbstractPhpExtension
  init
  desc "Imap PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://github.com/shivammathur/php-src-backports/archive/31b3988504b443365bfa4881257782b00919a751.tar.gz"
  sha256 "6f0f2a0dbb37e904859d7cc9ac12425434333a5c4b811b674621525430bd5472"
  version "8.0.30"
  head "https://github.com/shivammathur/php-src-backports.git", branch: "PHP-8.0-security-backports"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 8
    sha256 cellar: :any,                 arm64_sequoia: "f0236bdaf1fc317e614deea24327fafb8dfecad2217aa3ef035c503cf7b1b2c6"
    sha256 cellar: :any,                 arm64_sonoma:  "cfb67ce3ebe98bd997ab750f0410cf1641e3a99ad1b8724cad8f4ae11f68537d"
    sha256 cellar: :any,                 sonoma:        "24f87d5047c7c2601c06d12d4583baa8efd7fdcf4701159e2ffaf659bb439c40"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c681b62dbdd2944053147fbbe5f1816b1edb88c6538ad1c397a4af43cd6f38b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0aaa63c2b83cee94d7b43363d6a4a625e696d121343090a3c6c579006a382e97"
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

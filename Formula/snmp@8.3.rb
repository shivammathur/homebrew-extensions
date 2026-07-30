# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Snmp Extension
class SnmpAT83 < AbstractPhpExtension
  init
  desc "Snmp PHP extension"
  homepage "https://github.com/php/php-src"
  url "https://www.php.net/distributions/php-8.3.33.tar.xz"
  sha256 "e293ed620cec74651bb4a071317892a478aa6840fab22db45c72d77cd42f9676"
  head "https://github.com/php/php-src.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://www.php.net/downloads?source=Y"
    regex(/href=.*?php[._-]v?(8\.3(?:\.\d+)*)\.t/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "1d48db59ff7820989661fb82ed5d3f69708eb5ec9ca536e60745df414f2b3252"
    sha256 cellar: :any, arm64_sequoia: "e0bb25ebea401f5bac0da2924a4293b6395d73bccaeefb027bfadf772d565387"
    sha256 cellar: :any, arm64_sonoma:  "108f173249a25f7f91eacc289fe5b161b9662391ace6534c8ae24d3c6b46c685"
    sha256 cellar: :any, sonoma:        "12e11f42de5a6071144077049daec3bbb4880a08abef975256c5332d2a5feb18"
    sha256 cellar: :any, arm64_linux:   "c0a2bd0f9f93724a4bc2875381b8da6bea0af53d1ca28b322ad565f8b787013a"
    sha256 cellar: :any, x86_64_linux:  "dbab537544a8523ca958cc373c9a256ab1b929ebe10983c39e5b0220a0700cf2"
  end

  depends_on "net-snmp"
  depends_on "openssl@3"

  def install
    args = %W[
      --with-snmp=#{Utils::Path.formula_opt_prefix("net-snmp")}
      --with-openssl-dir=#{Utils::Path.formula_opt_prefix("openssl@3")}
    ]
    Dir.chdir "ext/#{extension}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end

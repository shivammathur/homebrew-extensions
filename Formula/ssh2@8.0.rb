# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT80 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.4.1.tgz"
  sha256 "7bca5b23f731db9d8ed0aea5db9bb15da8ff133b0fbba96102b82e95da4d8764"
  head "https://github.com/php/pecl-networking-ssh2.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_ventura:  "2f815695ba078b722211a2194fb1274b3756c53ebb87b3b26dee8021b38f0d2b"
    sha256 cellar: :any,                 arm64_monterey: "9241d20ab4f4c03acd6d5f8b7178aafde55de15796fb637a54449df6660b81f2"
    sha256 cellar: :any,                 arm64_big_sur:  "a88b79c4384a699500e92aa2016790fcaba89166d09a84654864e1afd137b3d1"
    sha256 cellar: :any,                 ventura:        "6c80b3aecfb61095e1bf1907916813f57fa00f42d8ddf5df4ffdd39d7a2b70eb"
    sha256 cellar: :any,                 monterey:       "d7bcbc61299689a3c671fa6bd262639aecc34720f68f6a8dff7f811c0c6cc2f7"
    sha256 cellar: :any,                 big_sur:        "76e07f23a1e2b8b90509442234cdd75ba97d47ef26beb77b9fa859c4429c490a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b35cfdd676ccdd8d7b1c3c82d9e5c77db42f35d9100bb5b4aeceb9b11a06b9cd"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end

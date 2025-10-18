# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT56 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-1.1.2.tgz"
  sha256 "c30a68145b4e33f4da929267f7b5296376ca81d76dd801fc77a261696a8a5965"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256 cellar: :any,                 arm64_sequoia:  "23db6698a351cb16b2638f6aac7fe4fefc068c9b4bc7c315769b8b2789ef845e"
    sha256 cellar: :any,                 arm64_ventura:  "0558a366efad09dab1c6a84d4cdeb08a45817946c6df54d404ab8d6d2e7cfe05"
    sha256 cellar: :any,                 arm64_monterey: "e5e964ac15256c625525292826d45882f4d94745dab1233b2125568eecd4d989"
    sha256 cellar: :any,                 arm64_big_sur:  "93ba63e7a8f920921b75b4feadb7eed186e8aff2402890a7a299d4743dd57c7a"
    sha256 cellar: :any,                 ventura:        "7d67634e7570e5df7a1ef5cbc002eed94334849c12f9db0c4655751e50bc13f6"
    sha256 cellar: :any,                 monterey:       "7b69ac73f18b64520fb40cc33999e58425f9b656af1c2d031cc38bb03f39f967"
    sha256 cellar: :any,                 big_sur:        "d97011db38e6134b74cb0203e4b8af185544ea9c9fc8381021760a08889837ec"
    sha256 cellar: :any_skip_relocation, arm64_linux:    "a50464a484f685e897c587673e7d1225875f989d55ac8250ecdde81f061cda66"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "7d426a275e96f0a83e3576fce0fdb6cd93a3f9f9c572870dadb311a6fb3813f5"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end

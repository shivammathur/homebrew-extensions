# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.7.0.tgz"
  sha256 "1c82b5c4d7329229daa21f77006781e92b7603627e7a643a2ec0dbf87b6cc48e"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "369d7c03ab25ef5187ed79c5d13ae91b10e4bc5643d6f0bdfd1fb796bfc895cb"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "5b70155a8d86c73d8860521e1a617669dfb7f2dd57adc0826c3fec35ede18d87"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "a33bc33461e4664a1626bb0b5680a933556f522b01a16b5574c14d587307ef0b"
    sha256 cellar: :any_skip_relocation, ventura:        "4f39bf4613dbf08ec0bc698e1d30b3f8323f1b62f772d141aec7f7c927117305"
    sha256 cellar: :any_skip_relocation, monterey:       "bf555960f16b6dfcd9aaf554e277d030115e3443cc944d6522e97a490d9250c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6a129d0396484b994b722a38d9ef194ba7c63ff1de6ef444793af161d13a5aa6"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end

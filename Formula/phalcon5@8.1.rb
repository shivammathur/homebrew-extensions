# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.6.1.tgz"
  sha256 "9842c0f75e89ae64cc33f1a2e517eaa014eeef47994d9a438bfa1ac00b6fdd54"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "280efb6077d5b8670534747c70624846d91e1f90be70197cb1480c6922e429dd"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "3045ea83e259ec7f2c00a8da10c064fd7598320396f19ada83f4c5cf77dec713"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "d0d232e3e6ab7056cf9e9f50016bbae102efe9a7ef5b7cfbbe1360dbbff4c9b3"
    sha256 cellar: :any_skip_relocation, ventura:        "4857e0482664729458c953e80b9c00672792c6c2cff1914f2c795a58ff0c5c5e"
    sha256 cellar: :any_skip_relocation, monterey:       "d5971cea61bdea24458e3c65c5fb18651e80b2e7e8aaa2fef0dd9beae7132363"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9d05210c8cf4935adef9de573bf85c3b5112887276afdf4fee796bc10be0287a"
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

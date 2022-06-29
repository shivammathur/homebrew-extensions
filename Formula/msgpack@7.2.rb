# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT72 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.1.2.tgz"
  sha256 "912ff4d33f323ea7cb04569df5ae23c09ce614412a65c39c2ca11f52802abe82"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "93386440da57dfe9ebb378b04237f0d18007646719edba94f71ee283d9279436"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ea65a13a9e4c45e778f4fde007f0ec03603cf8b28519db480cc3703af494eb13"
    sha256 cellar: :any_skip_relocation, monterey:       "f859e11a84e243763e3fdeea04fdfedcb64a92337ec7da2b5afc0bfd291298ba"
    sha256 cellar: :any_skip_relocation, big_sur:        "79749a0ab705afe28bcd1a4bf6845b09b209251769fbf5e4d60214c75c59bda5"
    sha256 cellar: :any_skip_relocation, catalina:       "271f6efee3644314828f2dcec86b58eb65527efb9ffd1109805c538406b920fa"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "aa6b422006098648dda416c314bc4d94cd20e30262c3485fddadb686cbb4b4ad"
  end

  def install
    Dir.chdir "msgpack-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-msgpack"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end

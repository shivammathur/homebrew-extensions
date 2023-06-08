# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT72 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-2.2.0.tgz"
  sha256 "82aa1e404c5ff54ec41d2a201305cd6594ed14a7529e9119fa7ca457e4bbd12a"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_monterey: "93386440da57dfe9ebb378b04237f0d18007646719edba94f71ee283d9279436"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ea65a13a9e4c45e778f4fde007f0ec03603cf8b28519db480cc3703af494eb13"
    sha256 cellar: :any_skip_relocation, ventura:        "8ba3c4da0e026aa5ecf48f1146dd57b1b2ad629579b5c79a38b968dbdf8fe044"
    sha256 cellar: :any_skip_relocation, monterey:       "3737b4ce5fe903fafdfcc0bc9e5ea020fc33ef4893f55a71080874021a31af0e"
    sha256 cellar: :any_skip_relocation, big_sur:        "79749a0ab705afe28bcd1a4bf6845b09b209251769fbf5e4d60214c75c59bda5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d332c81a18d636b7502c2c759bc02ec597c19ca0e3cf5fb2d5d4873b3874cce0"
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

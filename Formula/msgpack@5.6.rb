# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT56 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-0.5.7.tgz"
  sha256 "b8ee20cd0a79426c1abd55d5bbae85e5dcfbe0238abf9ce300685fbe76d94cdf"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_monterey: "882416bfa38bb9fa3bb2f0758b6883161ff8ebf20e8af3ad628b59c3b7b8e974"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "186575f18d0654732d9976efca42de9dfb3750e941896710cb594499bade6c22"
    sha256 cellar: :any_skip_relocation, monterey:       "14b44f6658bef54b3b2d2e7f0baa5cb2ae02dfc6feccdf10ded9b43a85b0261a"
    sha256 cellar: :any_skip_relocation, big_sur:        "4055d3f5675db346da1da2082a22dbc3d5ebe7e670727d4f2c324b0d2653286b"
    sha256 cellar: :any_skip_relocation, catalina:       "81f02a6ea594a2f59bc735a0140709c63eeb2043dd592f2312bf67aafc6066e9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "f0382f18e69fa8c0cfc3d740c3f2e0f70b306c44f4215df9542b40f981bf9604"
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

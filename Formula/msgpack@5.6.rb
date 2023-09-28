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
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "3d02a27f65e6019ee52ee7ffbb29a646dbdc19ecefb77bdc9c69617da8f3b15a"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "87d8b2b2ee230c1b581a0c5ca648e3083f482bd8e1712600dceb0eb6f51b6cf8"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "882416bfa38bb9fa3bb2f0758b6883161ff8ebf20e8af3ad628b59c3b7b8e974"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "186575f18d0654732d9976efca42de9dfb3750e941896710cb594499bade6c22"
    sha256 cellar: :any_skip_relocation, ventura:        "3656c60572cfa29279a08b43c1afd410eb212533bb658b55d8a5aef3cfac965c"
    sha256 cellar: :any_skip_relocation, monterey:       "22f761ef5b8bc879b89eacacd969bee9d61e18799f8e03d130f910da426cb6a0"
    sha256 cellar: :any_skip_relocation, big_sur:        "4055d3f5675db346da1da2082a22dbc3d5ebe7e670727d4f2c324b0d2653286b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "032702eaa010d4e1ed482ea6f57c2bd3870e685cc29973c60adcb41553af2078"
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

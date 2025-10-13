# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT71 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.0.tgz"
  sha256 "55306a84797d399c6b269181ec484634f18bea1330bbd9d7405043c597de69cd"
  head "https://github.com/msgpack/msgpack-php.git"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "1e80ee9f05063f9b449fe89cc5886d23ec63b1c2a8def58754b694aae56ae4eb"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "13a96bd54562020884b270269bb0e5decef979733c6fcfbbefdbdd4b02c87fe0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "303c4d6eb5e9347d3fb01396c379fba033ea9e2af758b9cc0729a9c69d328a8d"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "fc258d5212e8973e6e8d0eb87173fdf594cd624e0844f3e6d0c618c39242d934"
    sha256 cellar: :any_skip_relocation, sonoma:        "c8da2b08ac31b833bb0940af5d11106eac1b4af9911a95f33cc9102fbded9e72"
    sha256 cellar: :any_skip_relocation, ventura:       "0b4695b2027dec878e0e73a49908ce636fcaf55a6d600d8707c0ac411d6ffd90"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9da26cd902ffacc61b2df942fedac37481a13c5187c259c974eeeb85bf58d900"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "feaa3bfaf75fda98ce6f4fceb22a2efa39491f043e62caaf332bd234b4af1fc3"
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

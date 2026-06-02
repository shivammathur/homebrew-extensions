# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT71 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.1.tgz"
  sha256 "e30be355ab79aaea4568692fbd6073fd7c7f50ea8d3cf12edce40fc0c921d868"
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2b63956f0c1d970890ca91c2232fad52ac75e92bb1bc6a5b655ad78fbe301f1e"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "517ce9587871ce20484c5d8e748bded4423065b6f540c0072f800eaf5a68517d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d4e4b9996e8b1c709c390864844ba52b35c6013d474e9bee8b4266ee0ba7c150"
    sha256 cellar: :any_skip_relocation, sonoma:        "7750e20a427b20176346515dcfd461b08b095ba6336c52a61da81a09d8af0e2c"
    sha256 cellar: :any,                 arm64_linux:   "bc6a48379edb0b1e1595246cf066e94331b0e4738f257edd594770d741b15d07"
    sha256 cellar: :any,                 x86_64_linux:  "634616707e88a9ce4bbeea215129d654238db350fce514d0eb2a1c928126ddb3"
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

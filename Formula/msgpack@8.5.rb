# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Msgpack Extension
class MsgpackAT85 < AbstractPhpExtension
  init
  desc "Msgpack PHP extension"
  homepage "https://github.com/msgpack/msgpack-php"
  url "https://pecl.php.net/get/msgpack-3.0.0.tgz"
  sha256 "55306a84797d399c6b269181ec484634f18bea1330bbd9d7405043c597de69cd"
  revision 1
  head "https://github.com/msgpack/msgpack-php.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/msgpack/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "07dd0669c352466c14c935b75422f549dab4e41e3af04a2c9523d40a30f2ab09"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "07107bc497fb39747c0e1cfb810b942ae6e751086bc9a325a94ddde7a8552652"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7ec5977c1593f0795363f115591d0b324d962e72cd7610c0c7d0e18e36bc1a6e"
    sha256 cellar: :any_skip_relocation, ventura:       "026063efc38f97fb227c85116fd29d69d372f2ea594228f4210bce6e87e83dcd"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "bb00955fbba95ad965386f40d6af6e53577583c91128e2205d3ac36a24888a14"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9e3f52af4149da86dd3a366e2b67a1483e568ab0a54daa194856b6ccd2faf1c5"
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

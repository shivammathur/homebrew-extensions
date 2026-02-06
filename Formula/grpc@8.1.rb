# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT81 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.78.0.tgz"
  sha256 "c846ac9164930897fea9c55bad52aeb9f99a03cce64e694bd80f781c59baa0a8"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "859f654effb7d0574ec713f73f1a9d5659a08d84e20027988474557b8df34cbe"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "28c5e6942af68218042dad63203d1875f7ac7873010cd14773548783dc6b024a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "46d3379c99c84a1b4c97401cea4409100e7d6569df5cfa779cf4d5995f2c94bb"
    sha256 cellar: :any_skip_relocation, sonoma:        "58ed96a6bdd51770a48d2f767e0e3b3a4f0acfea47d764c8142c594fd199a810"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "71520ab8724dbb7705a7490327c60e7d8bfcee2d78931ebf9c48a11bc8a60655"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "10e3e24b9a9ad8a281b323b344e08f5835dd375c05f2e5767527c2586652b9bf"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end

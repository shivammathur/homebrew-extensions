# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.66.0.tgz"
  sha256 "6f6b751bbf33a88f917ca11a5b32923223c106eb5f064b791f99c6f7a9c7e7c2"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "b0dcbc48c95403476a50030a05ad0978b08936ed9bdda26f0be35d53d3d11412"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "d8f2349b06781914284e937cb89eed8bcfaf85a3f67e729083f988654052b160"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "fd5f91c41edd02aa3e7055442b67e88f549e01589815f64635ca1bf8f6449a17"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8d05f61394cc3342475ce3cabde2e68a4d85e4b2c3f8787b4d0859cad1b07c6f"
    sha256 cellar: :any_skip_relocation, ventura:        "67fdf68a74d3864cc3c44cbbae3e08418be36b9da068497d81ede472676514a9"
    sha256 cellar: :any_skip_relocation, monterey:       "404c1cfb4c843ddc94fc4585e7ec42a545c0038a54df2c6abd255b904f78f776"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "762a439c9048217b258882d5f955dd0ebedbe0fa51789c58b9b6773b1c6b4de5"
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

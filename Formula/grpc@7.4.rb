# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.46.3.tgz"
  sha256 "2aad61230afda3192eedad25be918bda628e6aa18bf1ed7e3bcf1944e6e4f4d5"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "863559408573bbdfaf1aec2f3336007064a0bc33f44881d1fe628571d3f98140"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "284d34b21160aa84b4a197fd914db2cdf0dd12e783946da8f9e9b2fd04f5a3a5"
    sha256 cellar: :any_skip_relocation, monterey:       "d1716d239177756f1df6e544bf1beee5aa1b0981c95ea4d1d50948a31d08a7e1"
    sha256 cellar: :any_skip_relocation, big_sur:        "87b22663443b725ee05a25bbbe78afd1fc13ac7fc1f91eced99acda9a3d6f155"
    sha256 cellar: :any_skip_relocation, catalina:       "192e9df2afcbdad04c9404c03ab2574473e4c110f200f59097e07bb33ec96c43"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "48c00527e5d87c76b64f645a4cbc972a13bf9751f3a0da76549d0f1690d12c36"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end

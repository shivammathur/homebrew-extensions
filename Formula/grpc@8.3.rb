# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.56.0.tgz"
  sha256 "bb3c58314cc4c4c043b70bf7162a4ebae507834bf5c2a014b67ebd8d70109dfe"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "714b855426b65bb7420332119eeb5446872abeff511e9a9acbc32f19f763d31e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "b469741cde6b05a91183630e53afce636368952e53363573c94927a3e2c56989"
    sha256 cellar: :any_skip_relocation, ventura:        "443ff8cae966c4e10c07e15d2270baf35fd5eb332b78d51265ca62e4f9c806ad"
    sha256 cellar: :any_skip_relocation, monterey:       "ada33790bed7fb81833488a1dfb0951a151b8f7686a1e08532599af179088f0e"
    sha256 cellar: :any_skip_relocation, big_sur:        "1aa83771b45efe05bf471b746d7ac7059a7ae65c273e522e0447ef5ee93e1361"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "fe326da778bd2bf2c6c39034c4673226192557ae11403a4676451243ae2159d4"
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

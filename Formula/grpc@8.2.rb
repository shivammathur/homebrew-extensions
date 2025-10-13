# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.75.0.tgz"
  sha256 "d2fa2d09bb12472fd716db1f6d637375e02dfa2b6923d7812ff52554ce365ba1"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "390b318f301db550e175b79e4408ed6a716bfac05d29681ea3943d833bdb8f09"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "1c4fad82b0feb64568a81aef3fd5d902f0f88d9aa3adbceaf6b6c703e0dca24b"
    sha256 cellar: :any_skip_relocation, sonoma:        "0fed8d4d417a5de12a19d0ea721834123c2a0f812dbd7e1a11e5771c311487bf"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4cbab1e1ff8670993adf3dc9bfbf10c873fa7982c9faef9f80f15f9ae5fde2ce"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6d4e876007606da6728ab6814ce8f7198c7240c930845445f6c0a50f586b9d93"
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

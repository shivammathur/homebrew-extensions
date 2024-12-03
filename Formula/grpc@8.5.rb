# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.68.0.tgz"
  sha256 "4e022e052d5b7997efd42f3b67f1175dbbb772cfd435570852febc0f569065bb"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e7f1b8a5dea553e7a52eb1cfe7fbe1bc460d13144766ed9d7e47e59250eed92b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "29fb3bde86bc1b99e7fc345ec583d0b63bab7531e42649cb37e913e1dcd82c8e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "a9fa4c43d3a865b84f93bc08e1366aa22af05f277d157632cd736740660788d9"
    sha256 cellar: :any_skip_relocation, ventura:       "d2980f5f6fe46388d113882f3dfeac537c00ddb52e965aa6c0f78f010cf17a92"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4360f2675f173b345eec6d395ea9e8cada9cdff8aebb80b09f702eab29b8db65"
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

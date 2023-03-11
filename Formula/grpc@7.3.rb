# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.52.1.tgz"
  sha256 "f8ce3ec8ab3678c70d57fe60982dcb6562a6cc162718cfbe74783915b49803c4"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "37d5dbcc9a2a7900decb68afb9c0502da3e5ef197211a0d64899a19596ec511a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "1b11acf41c84e21c65d376d7294ce18e119ceb70f1597b89451c7a1992ac7685"
    sha256 cellar: :any_skip_relocation, monterey:       "843d3d63ed5cf6e6db4c632b660276d832480c4eb3e6ab05a96ce9f1ce3d607c"
    sha256 cellar: :any_skip_relocation, big_sur:        "6b69ad4c2f9847cef45fb6063038f4b196fe5bc7c4896e53233a7783ff562e96"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "6c2efa89ef137bfa5352536efb034bb10c4ddbcecd6c4768f5249f6a976a097e"
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

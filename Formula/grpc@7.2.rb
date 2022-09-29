# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT72 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.49.0.tgz"
  sha256 "dfcd402553a53aac4894b65c77e452c55c93d2c785114b23c152d0c624edf2ec"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "21620bf092ecd3246a606724b30a860ea4d549f71b99ea04d471e5d46f19724e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "1d11f3ab351b96e43b61431bc48f24e78b732cb9d69e801f76669a398031466a"
    sha256 cellar: :any_skip_relocation, monterey:       "aaba5a5c8871b318e6b55376698af9514769ecb9541feaf614b6e0633c5814f6"
    sha256 cellar: :any_skip_relocation, big_sur:        "06b12df37c0144e1606e8b996d3ad16409e6c11fd81e5aadde3160a9454d208f"
    sha256 cellar: :any_skip_relocation, catalina:       "a0b5b6bfed9c79c755929c69997ce63339d9f02d912402142780f00cacf80240"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "9acc1a359b9c8c193ef4c2cdf0050115fbd146ae563d8ce90964790768e629ec"
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

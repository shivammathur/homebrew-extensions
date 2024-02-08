# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.61.0.tgz"
  sha256 "7efeff25faac9b8d92b3dc92e6c1e317e75d40a10bdc90bb3d91f2bf3aadf102"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "3bc99e9ccea8b7ece67cb9186bdeb8755feb7f0a5051653be83bac8caaa26e7b"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "04574559b9907f999865d71c5a5949996f5f44f6ee4153d8f18865046c62badd"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1f32bea40188f903a9f3131671d9c13754acb711620f1632e19db225a10e6888"
    sha256 cellar: :any_skip_relocation, ventura:        "1f8164e65e9105e6e47f403e31d395773865ad66d344ac49ee651769b6979004"
    sha256 cellar: :any_skip_relocation, monterey:       "66e8f02fa567ed4abb50e27fae8444e11b0ebac97b931309ec63e78e7fa635bd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b6396584b18c047da7b29eaaf67ad3e3e6d1ab41d2de50f0e3d84bc4694eea42"
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

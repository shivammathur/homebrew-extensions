# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT82 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.68.0.tgz"
  sha256 "4e022e052d5b7997efd42f3b67f1175dbbb772cfd435570852febc0f569065bb"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "6fa70af2d8f86be55601e07b8ac1d31090db68411dcce24b5a6b7248d0aca192"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e11b03e8dc8fe180c32f5ea98d2a8058e449efac5b690a94ecd54f770989610e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "5357481da6ca4e575be033cee89b74305b8588a9f650a34c4207db1be77edc6d"
    sha256 cellar: :any_skip_relocation, ventura:       "945a34925016763b46d40dd87796d13368dfca9c3a68cead65f2eee9fbc9c26d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "77c7ad752df08f9f5686414e31cd7527723481b712a8e67d74930c2dcd2d2012"
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

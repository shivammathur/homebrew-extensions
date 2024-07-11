# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT73 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.65.0.tgz"
  sha256 "bee9d16d8512189498708bb72b4bc893c1480cc39012045561de67f9872d6ca0"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "72d5485321d39a2f4e54e90413714823dd4f798301aa6b93016c83ba8ab4c601"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "12fca33ed2dbcdb663f1e5a58ed94383098af3fd15accd6641ec843759acf9bc"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5132e8ac5525100436ed99758cecf22b009039928a436c9fabada6fd972f3a6b"
    sha256 cellar: :any_skip_relocation, ventura:        "3e017ed495913d478234046a4b625f939e35765cac98ca011550fca57e53c267"
    sha256 cellar: :any_skip_relocation, monterey:       "de4d4eb510abda854508c98eff6f25b3a78a2d1716d244a111a23d8eae597a3c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "bbe5753577c331a0f80dde7f1ddb36c8f0bc1e5c0d5465add1f3d63471be74ed"
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

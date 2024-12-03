# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.68.0.tgz"
  sha256 "4e022e052d5b7997efd42f3b67f1175dbbb772cfd435570852febc0f569065bb"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7bd17c44569fe50d227dc0e129f6dd9519b38f34ebe3c4dc626b9e0526d58f58"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "947a10b9d26ec8bdd89eda67c54d8291880c4b67a396618bc559835ddf725053"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "681f858b926b6add89f22a5fbed23ac089a1bf6cb2ba73291786c051dd21daa3"
    sha256 cellar: :any_skip_relocation, ventura:       "045a200d2d5a9bcb340e5db012c2e61e205e5ab855ca91b82cca63df9ad170b0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "63d21295801f6a21695345651533257847514db34832f319f440b41dcb33989a"
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

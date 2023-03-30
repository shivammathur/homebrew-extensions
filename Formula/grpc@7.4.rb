# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.53.0.tgz"
  sha256 "10b214a785205bf8c5b3b8ebbeeddfdabce63a9c44399f250ba26763ae5646ab"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "5e2d40d6ff8c1512945438b3991328523435bb6671868da5a4a964fd10e1bd87"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "f3f1fdc8e6bcc324574648f2f9fa593566708f507f70ed52554d67f5160e1256"
    sha256 cellar: :any_skip_relocation, monterey:       "f6141957acea38d2fd5a8da50c36cf309813e5a2148ed638d7b3f9739ee341a6"
    sha256 cellar: :any_skip_relocation, big_sur:        "afce77b6df6c92334bf8337bf1ead80f21b14e55af5a7d6a30f2b4ed3902c46c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "01907d6f4cbd84e7c62574de0748648d4349bc176fcf561338cfd4b88b5b3292"
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

# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT71 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.69.0.tgz"
  sha256 "85ef59edd3517b377736c49a73799ead4729a82b960474b8842c9f89d2fbf222"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4e98c5c4000e79e2a68bd21d672325cc2f43254d9fa13ea4cf57305dcd6ea819"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "975c3291cbc8eda6523211ab0c4e2906449d0dd5544358c1398d58e53f06e53a"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "06a91a2e54baa532598aa344134055963161851ad4b0a7c0914fe28c75829666"
    sha256 cellar: :any_skip_relocation, ventura:       "6b641bfc58f9e220b86ec88529240927e75a3273eb03e7898a5e7200565a33f0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6125e67bfa05cda34adf4f055edb6ce4490f3d70f01732594e0fb27ad1750972"
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

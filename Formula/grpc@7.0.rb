# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.46.3.tgz"
  sha256 "2aad61230afda3192eedad25be918bda628e6aa18bf1ed7e3bcf1944e6e4f4d5"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "4ba5531ae1bc3b73a1753c51ee4095741323f8f10029aa42270a6edb2937ee8f"
    sha256 cellar: :any_skip_relocation, big_sur:       "58fedafe3291d79529ce6e10f006e1660902d379c0f78d7691174293ab82d877"
    sha256 cellar: :any_skip_relocation, catalina:      "f087144ca46bfc733995974dff81b782f3b044ddda63d7cc8c6aca9a88d317fd"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f8f79326edbd203075f51e97eb4a51ee6f27a5bbd1f2f2a22bb600ad3c486524"
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

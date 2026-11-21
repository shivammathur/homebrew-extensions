# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT85 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.85.4.tgz"
  sha256 "eb584cbe54ff361a54a9c0628bb3273b141e7900f5a6d89a43f97137875d7cec"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "4b453b6c2fcc063ce5c62446eebf1ba5f9165fedbf25a4d73b01658b71ec3217"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "b9307dfaca0e5f90822991b96a11c16e0411dde82e03c349381ef1ae27191587"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "c1178cc8937c92f136728cc8b484e53cb11fb71593a60b23ffcf62429a862056"
    sha256 cellar: :any,                 arm64_linux:       "ab7145fd78f4259ed4f987986617c69df0a37a54a74167b69efd91d9a33c5913"
    sha256 cellar: :any,                 x86_64_linux:      "0cf3df358d1b9d1619664e1591faafe35565ab1539600d192763e423a5e70fce"
  end

  depends_on "grpc"

  def install
    Dir.chdir "grpc-#{version}"
    patch_spl_symbols
    inreplace "src/php/ext/grpc/call.c", "zend_exception_get_default(TSRMLS_C)", "zend_ce_exception"
    safe_phpize
    system "./configure", "--enable-grpc"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end

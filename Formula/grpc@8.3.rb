# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT83 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.84.0.tgz"
  sha256 "555716233a5cc9a6baa605719f87b7688a88fb8bfdd9b4493396276244d56625"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "5513cd67bc4ce0300706fea9fbaa23ffb993f9138ddee8b2e29f1ad1264f3ae3"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "2922abe52c25c07431ddda1248735c661e50d85127b18763c12f720fdb875ca1"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "fbb46895627dd3a26dc9a8e6b70b0bedee886e2d5e8d05c3ad596c06a9390f4a"
    sha256 cellar: :any,                 arm64_linux:       "8902d8b92e779424866ea76bcae8f75115529b7588c47d8a180f1627b2bc3e73"
    sha256 cellar: :any,                 x86_64_linux:      "4666e4c71681648382ebae27bee23aa06dcb6f20ed4838aff4d6f67a69a05813"
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

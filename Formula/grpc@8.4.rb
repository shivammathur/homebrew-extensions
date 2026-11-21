# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "4efb1def0d75cda11a007c6a28470596b46f52e7470377968a67541efc6c602e"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "f2782d5cd28c2dce63da794962ef18c8de2c8941a83875813a5e363de7157624"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "a7b1d5905413e56905810163c2d06541d3db3ad3b2492d8047848dc164a46021"
    sha256 cellar: :any,                 arm64_linux:       "5ed52f2c633ab46a0f1e75096c0d738645f1c7cd4de863a435f17b92dcbd81be"
    sha256 cellar: :any,                 x86_64_linux:      "97c2b28c20445489d406f8317c3104b2c0d98a6332a0650ce8b478f53b033457"
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

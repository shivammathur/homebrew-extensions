# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "84f061841e7c8a62b09b9035085cbdc937c09a5a11f662f3a975fa538b462dfe"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "f34c5dcede773d0289b866c2ca94383a8e9077aefe59b885394b51521e0ae815"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "84504258c20198dbab8665344cf85fd122debfcac1fda5076af31cc1dec98cc8"
    sha256 cellar: :any,                 arm64_linux:       "5fcb97848d7e7b9579555413b64c149089b79dbefc52eb3026cfed414334a031"
    sha256 cellar: :any,                 x86_64_linux:      "454ce466481b76fed5b8f08e72afa4ce874090b46c9acc4eb9cd70ed9e1f8cd8"
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

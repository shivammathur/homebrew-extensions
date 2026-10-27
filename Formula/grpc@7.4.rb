# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.85.0.tgz"
  sha256 "adaf30db949767bf0ff5a5308638e4b9bb5f711733204ed5a5e8f3014d80a174"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "55ce4f125fcb6d937e9761eb825c9e606d0a55b9eb646decf7c43987132bdb54"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "6d0f0200792c77a4f0d726177f3c60436f696b48ff8d5a84be6b8abb613d1a21"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "c188485a36782b23c8ee62a38cb7eb7e12562c2751280e27cd7c9231eea74ea1"
    sha256 cellar: :any,                 arm64_linux:       "057443fbe09a1dc2fa098c9445c8905270183160c2668a6f535ed53c87e61b1e"
    sha256 cellar: :any,                 x86_64_linux:      "154168ecd6f915185a905609c39025306eb63b3b6d258f2dad1c195ea2de3ee7"
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

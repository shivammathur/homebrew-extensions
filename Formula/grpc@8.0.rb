# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "f09e354525ca704ec67165813efd896f750b1667c6c8444a3a5db85562d88c64"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "e8c8ed32ef170aa1c8a602331f07eedbb7a7202b73f40604ac83680b5e5593dc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "a4ca3a43760363a463a967f046f35c97822f8cf297dd71c7bedfac973c33ccee"
    sha256 cellar: :any,                 arm64_linux:       "1bd6e14a80a14650750845537109499a458ee01c70762a763f32f20b1edc0fd7"
    sha256 cellar: :any,                 x86_64_linux:      "3cd91df43b25fc0a5d1eae7826202892d5dc095994d783f752a7b02ecaa7d6ee"
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

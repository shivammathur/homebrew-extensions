# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "96fd62e2af244d64a878db9738ee3ad34468736c26d14aa366af4e280bfaf158"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "397659919033bb82684518b9509a088e9d7d1a20951945dda0da6e99d6107b9f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "486bbee4bc2d5822da8bc04cf93a112988208ef6b34b8b0e46e4e5ecb6eba360"
    sha256 cellar: :any,                 arm64_linux:       "924c5aa9078dad345ad5b37fad8ba90ac42467412c18d3f388706c923858de04"
    sha256 cellar: :any,                 x86_64_linux:      "384299b49124a861031ab233fbe3350b50a4ac8525bbffa400dbb3987904801c"
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

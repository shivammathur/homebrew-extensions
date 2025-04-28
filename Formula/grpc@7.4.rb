# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT74 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.72.0.tgz"
  sha256 "715fe230c0b185968e92f8f752d61a878f9eb5346873848e47ff65d0af6947dc"
  head "https://github.com/grpc/grpc.git"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "fb0fa59688e8998d47e7c7d230f5dc9bba9f6643aa17d526616c2316f6952f00"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5d3eb83ad420b9b85f75a4272e1d002175ec082adc9aff8e511d97d6bb0cb2f3"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "7484551be216a72dca79a4a345859ba93fc52902d5c2b72556f181eafc821e31"
    sha256 cellar: :any_skip_relocation, ventura:       "f09da3c8abfa61135e2099a44a7f6bbb674ff3057ac61e2843ef086d8f1863d1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "fff951f1663f64548654f1f19044049bfa47374584bb7a4850af1649a2d5f43c"
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

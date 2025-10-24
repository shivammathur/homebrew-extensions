# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for GRPC Extension
class GrpcAT70 < AbstractPhpExtension
  init
  desc "gRPC PHP extension"
  homepage "https://github.com/grpc/grpc"
  url "https://pecl.php.net/get/grpc-1.76.0.tgz"
  sha256 "6e3d65695bb99de227054ae6431cee29cebabdee699ded55e97fc6f892eb4935"
  head "https://github.com/grpc/grpc.git", branch: "master"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/grpc/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2ccd7dc9de7e1804b4223dddd004d8a2a0dc61fcf6593e6bd427b29562eff771"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8dc2fd24e7b9f2450b2896cd972109383fc4de056fd3b99524cdeced767415a3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "465012de0e3e629331667e15bd4f4a8e8fe6e71628924e129835e14943776e42"
    sha256 cellar: :any_skip_relocation, sonoma:        "6d91696b70d455fa3c605def9ce0c29293bd5bceb64f67fda299ab70f234dd5a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "144ef5d237875bebb457e28969a07eff30870ab3b8d4a91d361c4b73a8cc47c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0581c6930e1c9aaaeff77514328cc3daec7901284705e6a297f0741054937640"
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

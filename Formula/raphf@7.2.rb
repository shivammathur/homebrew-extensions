# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT72 < AbstractPhpExtension
  init
  desc "Raphf PHP extension"
  homepage "https://github.com/m6w6/ext-raphf"
  url "https://pecl.php.net/get/raphf-2.0.2.tgz"
  sha256 "7e782fbe7b7de2b5f1c43f49d9eb8c427649b547573564c78baaf2b8f8160ef4"
  head "https://github.com/m6w6/ext-raphf.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/raphf/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1167b7d06978216ab4fd1c2ca0d1079dd8d956dfbad3e75172319f9b3e29dd25"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d42986ff2454d6d5750cbbb6b519b4927a5a17a9a4c472f48f8b59762447e6c7"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "3181aecefdeb3c82c66bcf71a372b7861ae8c3889f54e460228b3187e2eae7e3"
    sha256 cellar: :any_skip_relocation, ventura:       "e83bf92055a72e9ea4bd6c0bd337d03bebbf43aa757d2eaee8d74558c3a5c2a0"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "4d92bd57d4401bae0e3070a0ca01e4861d59f16151a7f6d23ac9eca5d6d09121"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "953e3f5b3d282d680c5c89d4446761b57dc7c85b8edb67ab92a06f1e8d96a3b8"
  end

  def install
    Dir.chdir "raphf-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-raphf"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end

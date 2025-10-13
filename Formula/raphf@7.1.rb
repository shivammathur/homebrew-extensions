# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Raphf Extension
class RaphfAT71 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "b6f2b2d0ef1c1440f7a53c07caf347f7933228c44ed7a2b19d05ae483a6f1fc2"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "0d2d2c0eccf5e8977fb73878f3ce2510ff38fd28856a530a7d64c5531eca6d4d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "cc549bd36b3610c9fd43555c6830275d9a8fc834661fcebcf8c9d8c64cc5c618"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "db787d2b70a03037be7f1534d1393017c3a5dfed847607ffd50f82a9dcfef270"
    sha256 cellar: :any_skip_relocation, sonoma:        "de23ab315237e27a5fccf6e44fc2e46a98c9e679bd1d79b1163b6884ceae3baf"
    sha256 cellar: :any_skip_relocation, ventura:       "a7de0d76002ef98698a2defc2fe25478205eca7972af8fbea31613b7b431c14a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a40c1581a54d435b13b88a8fdd0cac9a65f308d80a881724817973d0510a823b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5742c80fe6aa54ede467bfd21a974a4c100d717a4bf2e1ba6bbc7eeceb38c1be"
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

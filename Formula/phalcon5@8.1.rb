# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT81 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.14.0.tgz"
  sha256 "9160c586227f3ae64a282eae5eec4241107087ca66689ac44498fbcd2b3f3c52"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "4af9a80ad349aacd55ebb1278d08de2fb258e62c2fd4d38bda22768165728a4b"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "1ec77880b806557f1eca344f22c9a0deec550a60724cdc4762d9d09eca046b96"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2942f8b9e2db9f14ce7f9472d3dd6c86e24b643bbf2a581fe91f8db50f926450"
    sha256 cellar: :any_skip_relocation, sonoma:        "aaffe36aa94af962b8e19506130d25769be0d7529490605609bddda7ee692afe"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "225b478d12441830ed089fe6fcd7db9da641ba54da3a3159573ac9a912f976ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "40b5bbe8eb93f977ed5cf61883332bfc43fcdf65d20a994537a6090631b73050"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end

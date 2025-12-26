# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.10.0.tgz"
  sha256 "3b552ac17fae44512298f43ec47cd055679d40e8c74b782743021dce77859eb1"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "459d8f4ac011ad38011f91f6b1a5c2a059fcd52d8df20520ef18014df73d8e6a"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "53ada7a4b6c7cfd1049267ee2e4627bd54b43792c0e5554fcdafcc68dadb3cca"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e9c3ad8e1681caf36f688d767d0c991bfc5cdb7259326eed6668a135bb7c8b95"
    sha256 cellar: :any_skip_relocation, sonoma:        "164c870a0d65efe3a87047785bb7556b1c134f77bce7dc7eb747dc2f1985ba80"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5a86746074b8c8a7779befdac4b53e87f0443e03a9890165fb6410739a782dda"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f97c62a717238f2681a3257efef16d042e23c8f2c232d73ddb3d1ab9a59a84a3"
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

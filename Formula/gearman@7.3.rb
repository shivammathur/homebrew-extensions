# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT73 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.2.1.tgz"
  sha256 "b9f826c90c87e6abd74cc3a73132c025c03e4bd2ae4360c4edc822ff651d694d"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "f3b70d4a4a431fd04960d3b5b490f2aaaf14b0fca6ba76129057da832cab7dc3"
    sha256 cellar: :any,                 arm64_sequoia: "16af7e962fc1431890e3867bf3fc2c64473f6706b10e1841afeb5aaaf7aea1d1"
    sha256 cellar: :any,                 arm64_sonoma:  "c290a8b7993e44663cf41c15f802a3c8e7ec0cc9020ca3a6edc5b3d0a11252e2"
    sha256 cellar: :any,                 sonoma:        "6638a90b9a04728a6706b1a60db0e21d182aeaa883b4e9281abb73475fd088b4"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "8b7ef51a8ac4c43121c67833fbf486efe0df734c763f3b97bc560c31b2a2525d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c2c891730112a469f918d87db6c6d4d0445203ca2b1100d8bae84c5bdeabf9e1"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end

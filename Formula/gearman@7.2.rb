# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT72 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "ccbe5f763dccf9bb6417aa391ed54efe04bf07d54c900daccbfc2ad2bab52770"
    sha256 cellar: :any,                 arm64_sequoia: "2a6dd014c6ae40e31de0df6cc2442460ef5e75d4cbffe2445d2c295228550dd1"
    sha256 cellar: :any,                 arm64_sonoma:  "ea0416a82a6715d9b69930c9ea2ca19873d5567a932606c60a64d78902d7dc8e"
    sha256 cellar: :any,                 sonoma:        "5dc2d1248820a535faf705aa99fe3e24c7c1ab455051da05e898d9b7237fc6d6"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ad8b593742217a9cda27a5daafc5914415930e28fd345cd461ec082f9d4a2bb4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "856c36c9eec0937e35c690195d143bb6cf472bad2863c44e868c964913d1ee1e"
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

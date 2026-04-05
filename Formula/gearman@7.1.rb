# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT71 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.2.0.tgz"
  sha256 "2d2a62007b7391b7c9464c0247f2e8e1a431ad1718f9bb316cf4343423faaae9"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/gearman/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "97945adeb966ccec48df3c3c36deef9ef8247b5560c49275a50cb0dd7797d26c"
    sha256 cellar: :any,                 arm64_sequoia: "e6282b16f6ea08f757fca3da630ed90e440410420cae88821227b09b92a7a059"
    sha256 cellar: :any,                 arm64_sonoma:  "6cd14b25be2d3b90acb80a6d17bc6497304ff985ced6aa764043769e4c6a749a"
    sha256 cellar: :any,                 sonoma:        "74b39939b33bbad738b14694a768bf27bfc6fad44a0e2e38fb5a7938d6aafc5c"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "5be999adff450fc5ddbf149834ca2ead76454b72f1d29d2ce63b01184b401fe3"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "08daa318f19d294f78a3cb48a66fb14c33d4645306ce9bd0e0b567c0db0ea801"
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

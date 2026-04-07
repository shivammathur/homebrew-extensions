# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT85 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "e60c9cfab9bdae4394ea5129d710e8436b61e08541aba3bf29ef20ec8bcb4b5c"
    sha256 cellar: :any,                 arm64_sequoia: "d22ec60097a9458351b8a4628b8c8b43212b3a31310d7ed8d707caf945f1fb7b"
    sha256 cellar: :any,                 arm64_sonoma:  "7c909f2445c51432d13b431d9e9d5e5e3514e16961ff03ccb712f7a969a9b627"
    sha256 cellar: :any,                 sonoma:        "f4567df16e518b0aea8772bb54f2a8dbbc623298913974c65016f95983b82962"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "e8f0f800690605e9c0563c181d3f792d957e887f826322961a441f9c237baa35"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "bdf7401b05440aab854c1acd72bd6d6517d0401e61f9dbd7a90fe93abaeaf195"
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

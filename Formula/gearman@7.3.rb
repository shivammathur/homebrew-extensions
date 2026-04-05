# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_tahoe:   "c65eb0658945a19ea1d0dabac6af9bf7a73ebc02ea29c6faf27099e242f801e5"
    sha256 cellar: :any,                 arm64_sequoia: "8affd63c234adfc1986511110b0d82d0129a88311148964a1067046db4547236"
    sha256 cellar: :any,                 arm64_sonoma:  "e45dd37b2b6bfc1da20b93b967b63ef585d90532617c72c0eaea13979b04d0ca"
    sha256 cellar: :any,                 sonoma:        "f0ce1dae1a43ccaa7694e074c4c5aa54dd09651d2f866d93a58f00818c52a1c7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0aa01094a449678e3459553165714cbd504ed2303307d7b9d2250fc1921a7927"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "972590485af80ebf2bfaa3acc5cc06abb6c55a19768fef01b73a9d2cd1b7d9ff"
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

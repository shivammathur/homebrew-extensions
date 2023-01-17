# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT74 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.0.tgz"
  sha256 "77075fc250fac2d3878deb255d44efc3ad76cf7b2c7f1af420cb17839a03c0bc"
  head "https://github.com/php/pecl-networking-gearman.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_monterey: "a96e9405cfe0ffb3dfdb363e51a903043a3af5ceee5f6c34c882affd8e769d28"
    sha256 cellar: :any,                 arm64_big_sur:  "2f24197554ec41be1cf98e338d08204e58c6cb97288e685189a22e89d2e0bae2"
    sha256 cellar: :any,                 monterey:       "03cea4ce8ce8dd4f382710c6ed31f8ba204cb2a3ecded222257213722ed21a63"
    sha256 cellar: :any,                 big_sur:        "21a8667363a3d23f395f887440da8feec117aea2cec3fe75ac3ce7d9ab360675"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a51b4fb5d0f0408cda58275f32efdec5b739ced4c3407a23dac5dd6a129a024b"
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
